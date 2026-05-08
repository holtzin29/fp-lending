from ethereum.ercs import IERC20

# admin controlled multisig which is responsible for calling functions that retrieve fees from the pool
fee_collector: public(address)
# admin controlled multisig which is responsible for pausing certain operations
admin: public(address)
# we wont accept upgradable erc20s by design.
asset: public(immutable(IERC20))
# for each asset of the pool we will have a designed vault (USDC->FP/USDC) so uni-asset pools.
vault: public(address)
paused: public(bool)

@deploy
def __init__(fee_address: address, admin_address: address, _asset: IERC20):
    assert fee_address != empty(address), "Zero address"
    assert admin_address != empty(address), "Zero address"
    self.fee_collector = fee_address
    self.admin = admin_address
    asset = _asset
    # TODO: vault deployment via create_from_blueprint

@nonreentrant("lock")
@external
def deposit(assets: uint256, min_amount_out: uint256) -> uint256:
    assert not self.paused, "paused"
    # TODO: transfer assets, mint shares, slippage check
    return 0

@nonreentrant("lock")
@external
def withdraw(assets: uint256, min_amount_out: uint256) -> uint256:
    # we do want users to be able to withdraw even when paused
    # TODO: burn shares, return assets
    return 0

@nonreentrant("lock")
@external
def borrow(shares: uint256) -> uint256:
    assert not self.paused, "paused"
    return 0

@nonreentrant("lock")
@external
def repay(assets: uint256) -> uint256:
    return 0

@nonreentrant("lock")
@external
def liquidate(user: address) -> uint256:
    return 0

@internal
def _only_admin():
    assert msg.sender == self.admin, "not admin"