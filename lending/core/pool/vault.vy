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
def __init__(asset: address, name: String, symbol: String):
    asset = IERC20(asset)
    self.name = name
    self.symbol = symbol
    self.decimals = decimals

@view
@external
def decimals() -> uint8
    return IERC20(asset).decimals() + decimals_offset()

@nonreentrant
@external
def deposit(_name: type) -> uint256:

@nonreentrant
@external
def withdraw(_name: type):

@view
@external
def totalAssets() -> uint256:
    return IERC20(asset).balanceOf(address(self))

@view
@external
def balanceOf(_name: type):

@view
@external
def allowance(_name: type):
    

    


@internal
def convertToShares(assets: uint256):


@internal
def convertToAssets()


@internal
def decimals_offset() -> uint8:
    return 0 # for now


    

# we will build more functions as we go along
