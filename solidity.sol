
// SPDX-License-Identifier: MIT
pragma solidity >0.8.0 <9.0.0;

contract Vote {

    struct Ballot{
        string question;
        bool is_open;
        address[] yes;
        address[] no;
    }
    Ballot b;

    mapping (uint => Ballot) public  ballots;
    uint total_votes = 0;
    uint selected;
    function show_votes() public view returns(string[] memory,uint[] memory,uint[] memory){
        string[] memory q = new string[](total_votes);
        uint[] memory y = new uint[](total_votes);
        uint[] memory n = new uint[](total_votes);
        for (uint i =0;i<total_votes;i++){
            q[i]=ballots[i].question;
            y[i]=ballots[i].yes.length;
            n[i]=ballots[i].no.length;
        }
        return (q,y,n);
    }

    function select_ballot(uint s) public payable returns(string memory){
        require(s<=total_votes,"Ballot number doesn`t exist");
        selected = s;
        return ballots[s-1].question;
    }
    
    function close_vote() public payable returns(bool){
        ballots[selected-1].is_open = false;
        return true;
    }

    function add_ballot(string memory q) public payable{
        total_votes += 1;
        b.question = q;
        b.is_open = true;
        ballots[total_votes-1] = b;
    }

    function vote_selected(bool c) public payable returns(bool){
        require(ballots[selected-1].is_open,"Ballot is closed");
        bool already_voted=false;
        for(uint i=0;i<ballots[selected-1].yes.length;i++){
            if(ballots[selected-1].yes[i] == msg.sender){
                already_voted=true;
            }
        }
        for(uint i=0;i<ballots[selected-1].no.length;i++){
            if(ballots[selected-1].no[i] == msg.sender){
                already_voted=true;
            }
        }
        require(!already_voted,"You have already voted.");
        if(c){
            ballots[selected-1].yes.push(msg.sender);
        }
        else{
            ballots[selected-1].no.push(msg.sender);
        }
        return true;
    }
}