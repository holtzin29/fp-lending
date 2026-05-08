from ethereum.ercs import IERC20

total_deposited: public(uint256)

deposit_token: public(IERC20)

struct Position

def __init__(asset:  address):
    self.total_deposited = 0
    deposit_token = asset
    

def deposit(amount: uint256, min_amount: uint256) -> uint256:
    
