// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.5.9;

import "@0x/contracts-erc20/contracts/src/ERC20Token.sol";

/**
 * @title SampleERC20
 * @dev Create a sample ERC20 standard token
 */

interface ERC20Interface {
    // 총 발행량
    function totalSupply() external view returns (uint256);
    // 특정 계좌의 잔고
    function blanaceOf(address account) external view returns (uint256);
    // 토큰 전송
    function transfer(address recipient, uint256 amout) external returns (bool);
    // spender에게 인출 권리 부여
    function approve(address spender, uint256 amount) external returns (bool);
    // owner가 spender에게 부여한 토큰 양 확인
    function allowance(address owner, address spender) external returns (uint256);
    // sender가 부여받은 토큰 전송
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Transfer(address indexed spender, address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);
}

contract SampleERC20 is ERC20Token {
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) public _allowances;

    string public _name;
    string public _symbol;
    uint256 public _decimals;
    uint256 public _totalSupply;

    constructor(string memory name, string memory symbol) {
        _name = name;
        _symbol = symbol;
        _decimals = 18;
        _totalSupply = 100000e18;
        balances[msg.sender] = _totalSupply;
    }

    function totalSupply() external view virtual override returns (uint256) {
        return _totalSupply;
    }

    function blanaceOf(address account) external view virtual override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(msg.sender, recipient, amount);
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) internal virtual {
        require(sender != address(0), "ERC20: transfer form the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
        _balances[sender] = senderBalance - amount;
        _balances[recipient] += amount;
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(msg.sender, address spender, uint256 amount);
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function _approve(address owner, address spender, address amount) internal virtual {
        require(owner != address(0), "ERC20: transfer form the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[owner][spender] = amount;
    }

    function allowance(address owner, address spender) public virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        uint256 currentAllowance = _allowances[sender][msg.sender];
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        _transfer(sender, recipient, amount);
        emit Transfer(msg.sender, sender, recipient, amount);
        _approve(sender, msg.sender, currentAllowance - amount);
        return true;
    }
}