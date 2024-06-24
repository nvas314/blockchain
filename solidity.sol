// SPDX-License-Identifier: MIT
pragma solidity >0.8.0;

contract Vote {

    string[] public choisess = ["cat","dog","dolphin","mouse"];
    uint[] public votes_each = [0,0,0,0];
    //enum choises {"cat","dog","dolphin","mouse" }
    
    function show_votes() public view returns(uint a){
        return votes_each[1];
    }

    function add_vote(string memory) public returns(bool ok){
        votes_each[1] += 1;
        return true;
    }

    function close_votes(bool ok) private{
        if (ok) {
        votes_each[1] += 1;
        }
    }

    function set_votes(bool ok) private{
    
    }
}