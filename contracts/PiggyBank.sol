pragma solidity >=0.4.21 <0.6.0;

contract Piggybank{

    struct AccountHolder{
        string firstName;
        string lastName;
        address ad;
        uint256 userBal;
        uint256 userId;
        uint256 numberOfAccounts;
    }

    AccountHolder[] accountholders;

    uint256 accountCount = 0;

    mapping(address => uint256) public adToId;
    mapping(address => uint256) public userBalance;
    mapping(address => AccountHolder) public userInfo;
    mapping(address => uint256) howManyAccounts;

    function createAccount(string memory _firstName, string memory _lastName) public{
        require(howManyAccounts[msg.sender] < 1, "You already have an account!");
        accountholders.push(AccountHolder(_firstName, _lastName, msg.sender, 0, accountCount, 1));
        userInfo[msg.sender] = AccountHolder(_firstName, _lastName, msg.sender, 0, accountCount, 1);
        adToId[msg.sender] = accountCount;
        userBalance[msg.sender] = 0;
        howManyAccounts[msg.sender] = 1;
        accountCount++;
    }

    function showID() public view returns(uint256){
        return adToId[msg.sender];
    }

    function depositMoney(uint256 _amount) public{
        userBalance[msg.sender] += _amount;
        uint256 userIdentity = adToId[msg.sender];
        accountholders[userIdentity].userBal += _amount;
        userInfo[msg.sender].userBal += _amount;
    }

    function withdrawMoney(uint256 _amount) public{
        require(userBalance[msg.sender] >= _amount, "You don't have enough funds!");
        userBalance[msg.sender] -= _amount;
        uint256 userIdentity = adToId[msg.sender];
        accountholders[userIdentity].userBal -= _amount;
        userInfo[msg.sender].userBal -= _amount;
    }

    function showBalance() public view returns (uint256){
        return userBalance[msg.sender];
    }

    function showName() public view returns (string memory){
        uint256 userIdentity = adToId[msg.sender];
        return accountholders[userIdentity].firstName;
    }

}