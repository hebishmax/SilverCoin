// SPDX-License-Identifier: MIT
pragma ton-solidity >= 0.45.0;

contract SilverCoin {
    address public admin = "UQBw5LzsDZXeVBtKIOCOOc2eKN689ffblcK-qazXoE52qU6d";
    uint128 public totalSupply;
    mapping(address => uint128) public balances;
    event Transfer(address indexed from, address indexed to, uint128 amount);

    modifier onlyAdmin() {
        require(msg.sender == admin, 101, "المطلوب: الأدمن فقط");
        _;
    }

    constructor(uint128 initialSupply) public {
        tvm.accept();
        totalSupply = initialSupply;
        balances[msg.sender] = initialSupply;
    }

    function transfer(address recipient, uint128 amount) public {
        require(balances[msg.sender] >= amount, 101, "الرصيد غير كافٍ");
        tvm.accept();
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
    }

    function mint(address recipient, uint128 amount) public onlyAdmin {
        tvm.accept();
        totalSupply += amount;
        balances[recipient] += amount;
        emit Transfer(address(0), recipient, amount);
    }

    function changeAdmin(address newAdmin) public onlyAdmin {
        tvm.accept();
        admin = newAdmin;
    }
}
