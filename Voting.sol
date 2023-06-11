//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract electionApp {
    address public owner;
    // variables here
    // constror function --> assign the owner

    // struct here
    struct Candidate {
        string name;
        uint256 voteCount;
    }
    struct voter {
        bool authorized;
        bool voted;
        uint256 vote;
    }

    struct election {
        string name;
        string status;
    }



    // mappings and arrays here
    mapping(address => voter) public voters;
    Candidate[] public candidates;
    uint256 public totalVotes;

    modifier ownerOnly() {
        require(msg.sender == owner);
        _;
    }

    function addCandidate(string memory _name) public ownerOnly {
        candidates.push(Candidate(_name, 0));
    }

    function getNumCandidate() public view returns (uint256, string memory, bool) {
        return (candidates.length, "Hello", true);
    }

    function authorize(address _person) public ownerOnly {
        voters[_person].authorized = true;
    }

    function vote(uint256 _voteIndex) public {
        require(!voters[msg.sender].voted);
        require(voters[msg.sender].authorized);

        voters[msg.sender].vote = _voteIndex;
        voters[msg.sender].voted = true;

        candidates[_voteIndex].voteCount += 1;
        totalVotes += 1;
    }
}
