// Sources flattened with hardhat v2.8.0 https://hardhat.org

// File @openzeppelin/contracts/utils/Context.sol@v3.4.1

// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}


// File @openzeppelin/contracts/access/Ownable.sol@v3.4.1


pragma solidity >=0.6.0 <0.8.0;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}


// File contracts/Operatable.sol


pragma solidity >=0.6.0 <0.8.0;

abstract contract Operatable is Ownable {
    event OperatorGranted(address account);
    event OperatorRevoked(address account);

    mapping(address => bool) public operators;

    modifier onlyOperator() {
        require(operators[msg.sender], "caller is not the operator");
        _;
    }

    function grant(address _account) public onlyOwner {
        if (!operators[_account]) {
            operators[_account] = true;
            emit OperatorGranted(_account);
        }
    }

    function revoke(address _account) public onlyOwner {
        if (operators[_account]) {
            operators[_account] = false;
            emit OperatorRevoked(_account);
        }
    }
}


// File contracts/interfaces/IBank.sol


pragma solidity 0.7.3;

interface IBank {
    event Deposit(address indexed to, uint256 amount);
    event Withdraw(address indexed from, address indexed to, uint256 amount);
    event Paid(address indexed from, address indexed to, uint256 amount);

    function deposit(address to) external payable;
    function withdraw(address payable to, uint256 amount) external;
    function pay(
        address from,
        address payable to,
        uint256 amount
    ) external;
}


// File contracts/interfaces/IRegistration.sol


pragma solidity 0.7.3;
pragma experimental ABIEncoderV2;

interface IRegistration {
    function find(string memory imei) external view returns (address, address);
    function ship(
        string[] memory imeis,
        address[] memory addrs
    ) external;
    function setOwner(
        string memory imei,
        address owner
    ) external;
}


// File @openzeppelin/contracts/token/ERC20/IERC20.sol@v3.4.1


pragma solidity >=0.6.0 <0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}


// File contracts/Pebble.sol


pragma solidity 0.7.3;




contract Pebble is Operatable {
    event Data(
        string imei,
        address operator,
        uint32 _type,
        bytes data,
        uint32 timestamp,
        bytes signature,
        uint256 gas
    );
    event Firmware(string imei, string app);
    event Proposal(string imei, address owner, address device, string name, string avatar);
    event Confirm(string imei, address owner, address device, uint32 channel);
    event Remove(string imei, address owner);

    IBank public bank;
    IRegistration public registration;
    address public token;
    mapping(string => uint32) public timestamps;

    constructor(address _bank, address _registration) {
        bank = IBank(_bank);
        registration = IRegistration(_registration);
    }

    function setToken(address _token) public onlyOwner {
        token = _token;
    }

    function setFirmware(string memory imei, string memory app) public {
        (, address owner) = registration.find(imei);
        require(owner == msg.sender, "caller is not the owner");
        emit Firmware(imei, app);
    }

    function checkTime(string memory imei, uint32 timestamp) internal returns (bool) {
        if (timestamps[imei] >= timestamp)
            return false;

        timestamps[imei] = timestamp;
        return true;
    }

    function addData(
        string memory imei,
        uint32 _type,
        bytes memory data,
        uint32 timestamp,
        bytes memory signature,
        uint256 gas
    ) public onlyOperator {
        (address device, address owner) = registration.find(imei);
        require(device != address(0), "invalid imei");
        require(owner != address(0), "device has not owner");
        require(checkTime(imei, timestamp), "invalid timestamp");
        require(recover(sha256(abi.encodePacked(_type, data, timestamp)), signature) == device, "invalid signature");
        bank.pay(owner, msg.sender, gas);
        if (token != address(0)) {
            safeTokenTransfer(msg.sender, 1e18);
        }
        emit Data(imei, msg.sender, _type, data, timestamp, signature, gas);
    }

    function proposal(string memory imei, string memory name, string memory avatar) public payable {
        (address device, address owner) = registration.find(imei);
        require(device != address(0), "invalid imei");
        require(owner == address(0), "device has owner");
        require(msg.value > 0, "invalid value");
        bank.deposit{ value: msg.value }(msg.sender);
        emit Proposal(imei, msg.sender, device, name, avatar);
    }

    function remove(string memory imei) public {
        (,address owner) = registration.find(imei);
        require(owner == msg.sender, "caller is not the owner");
        registration.setOwner(imei, address(0));
        emit Remove(imei, owner);
    }

    function confirm(
        string memory imei,
        address _owner,
        uint32 timestamp,
        bytes memory signature,
        uint256 gas,
        uint32 channel
    ) public onlyOperator {
        (address device, address owner) = registration.find(imei);
        require(device != address(0), "invalid imei");
        require(owner != _owner, "owner not changed");
        require(checkTime(imei, timestamp), "invalid timestamp");
        require(recover(sha256(abi.encodePacked(_owner, timestamp)), signature) == device, "invalid signature");
        registration.setOwner(imei, _owner);
        bank.pay(_owner, msg.sender, gas);
        emit Confirm(imei, _owner, device, channel);
    }

    function recover(bytes32 hash, bytes memory signature) internal pure returns (address) {
        bytes32 r;
        bytes32 s;
        uint8 v;

        assembly {
            r := mload(add(signature, 0x20))
            s := mload(add(signature, 0x40))
            v := byte(0, mload(add(signature, 0x60)))
        }

        if (v < 27) {
            v += 27;
        }

        if (v != 27 && v != 28) {
            return (address(0));
        }
        return ecrecover(hash, v, r, s);
    }

    function safeTokenTransfer(address _to, uint256 _amount) internal {
        uint256 balance = IERC20(token).balanceOf(address(this));
        if (_amount > balance) {
            IERC20(token).transfer(_to, balance);
        } else {
            IERC20(token).transfer(_to, _amount);
        }
    }
}
