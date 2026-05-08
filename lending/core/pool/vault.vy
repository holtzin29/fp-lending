# custom erc4626
from ethereum.ercs import IERC20

asset: public(immutable(IERC20))
name: public(String[64])
symbol: public(String[32])
decimals: public(uint8)
totalSupply: public(uint256)
balanceOf:  public(HashMap[address, uint256])
allowances: public(HashMap[address, HashMap[address, uint256]])


@deploy
def __init__(_asset: address, _name: String[64], _symbol: String[32]):
    asset = IERC20(_asset)
    self.name = _name
    self.symbol = _symbol
    self.decimals = 18

@view
@external
def decimals() -> uint8
    return IERC20(asset).decimals() + decimals_offset()

@nonreentrant
@external
def deposit(assets: uint256) -> uint256:
    shares: uint256 = self.convertToShares(assets)
    success: bool = extcall IERC20(asset).transferFrom(msg.sender, self, assets)
    assert success
    self._mint(msg.sender, shares)

    return shares

@nonreentrant
@external
def withdraw(assets: uint256):
    shares: uint256 = self.convertToShares(assets)
    self._burn(msg.sender shares)
    success: bool = extcall IERC20(asset).transferFrom(self, msg.sender, assets)
    assert success # TODO error custom handling

    return shares



@nonreentrant
@external
def transferFrom(owner: address, to: address, amount: uint256) -> bool:
    # TODO: handle approval better
    self.allowances[owner][msg.sender] -= amount
    self.balance[owner] -= amount
    self.balance[to] += amount
    return true
    

@nonreentrant
@external
def transfer(to: address, amount: uint256) -> bool:
    self.balanceOf[msg.sender] -= amount
    self.balanceOf[to] += amount
    return true



@view
@external
def total_assets() -> uint256:
    return staticcall IERC20(asset).balanceOf(address(self))

@view
@external
def balanceOf(user: address) -> uint256:
    return self.balanceOf[user]

@view
@external
def allowance(owner: address, spender: address) -> uint256
    return self.allowances[owner][spender]
    

@internal
def _mint(amount: uint256):
    self.balance[msg.sender] += amount
    self.totalSupply += amount

@internal
def _burn(amount: uint256):
    self.balance[msg.sender] -= amount
    self.totalSupply -= amount



@internal
def convertToShares(assets: uint256) -> uint256:
    return assets * (IERC20(asset).totalSupply() + (10 ** self.decimals_offset())) / (self.total_assets() + 1)


@internal
def convertToAssets(shares: uint256):
    return shares * (self.total_assets() + 1) / (IERC20(asset).totalSUpply() + 10 ** self.decimals_offset())



@internal
def decimals_offset() -> uint8:
    return 0 # for now


    

# we will build more functions as we go along
