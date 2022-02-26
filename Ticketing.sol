// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Ticketing_smart_contract
{

    uint256 Ticket_Price = 0.01 ether;
    mapping(address=>uint) public Ticket_Holders;
    address payable owner ;

    constructor()
  {
      owner = payable(msg.sender);
  }

  function BuyTicket(address user , uint amount) public payable 
  {
    require(msg.value >= Ticket_Price * amount , "Amount not sufficent");
    AddTicket(user,amount);
  }

  function UseTicket(address user , uint amount) public
  {
    SubTicket(user,amount);
  }

  function AddTicket(address user , uint amount) internal
  {
    Ticket_Holders[user] = Ticket_Holders[user] + amount ;
  }

  function SubTicket(address user , uint amount) internal
  {
      require(Ticket_Holders[user]>=amount,"You dont have enough tickets");
      Ticket_Holders[user] = Ticket_Holders[user]  - amount ;
  }
  
  modifier onlyOwner {
      require(msg.sender == owner);
      _;
   }

  function Withdraw() public onlyOwner
  {
    owner.transfer(address(this).balance);
  }

}
