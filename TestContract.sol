pragma solidity ^0.8.24;

// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/extensions/AccessControlEnumerable.sol";

contract ContractErrors {
    error MessageTooLong();
    error MessageAlreadySet();
}

contract Contract is AccessControlEnumerable, ContractErrors {

    mapping (uint256 recordId => string message) private messages;
    event MessageSet(uint256 indexed recordId, string indexed message);
    event MessageRemoved(uint256 indexed recordId);
    
    bytes32 public constant RECORD_CREATOR_ROLE = keccak256("RECORD_CREATOR_ROLE");

    constructor(){
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(RECORD_CREATOR_ROLE, msg.sender);
    }

    function addRecord(uint256 _recordId, string calldata _message) external onlyRole(RECORD_CREATOR_ROLE) {
        if(bytes(_message).length > 32){
            revert MessageTooLong();
        }
        if(bytes(messages[_recordId]).length == 0){
            messages[_recordId] = _message;
            emit MessageSet(_recordId, _message);
        } else {
            revert MessageAlreadySet();
        }
    }

    function removeRecord(uint256 _recordId) external onlyRole(DEFAULT_ADMIN_ROLE) {
        messages[_recordId] = "";
        emit MessageRemoved(_recordId);
    }

    function getMessage(uint256 _recordId) external view returns (string memory){
        return messages[_recordId];
    }
}