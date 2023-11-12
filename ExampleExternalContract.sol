// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./Staker.sol";

contract ExampleExternalContract {

  Staker public staker;

  bool public completed;

  // Wonky way to setup Staker contract as this contract needs to be deployed first
  // solving chicken and egg issue
  function setStakerContractAddress(address payable stakerContractAddress) public {
    staker = Staker(stakerContractAddress);
  }

  function complete() public payable {
    completed = true;
  }

  // Logic to reset Staker contract and send ETH back
  function resetStaker(uint _claimtime, uint256 _withdrawtime) public {
    require(completed = true, "Sorry, cannot run this yet.");
    completed = false;
    // reset timing on Staker contract
    staker.resetWithdrawalDeadline(_withdrawtime);
    staker.resetClaimDeadline(_claimtime);
    // Send contract balance back to Staker contract
    (bool sent, bytes memory data) = address(staker).call{value: address(this).balance}("");
    require(sent, "Failed to send Ether");
  }

}
