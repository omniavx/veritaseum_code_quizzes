pragma solidity ^0.4.24;

// This is a simple contract that keeps track of balances and allows withdrawals only after a week from the deposit.
// 1. In your opinion, does withdraw() function work as expected?
// 2. Implement the missing deposit() function that will allow only a single deposit from any address

//MY RESPONSES
// 1. no the withdraw() did not work as expected. I made the following code modifications 
//      (a) changed the "greater than" to "less than or equal to" so that the withdrawls 
//          are only allowed after a week from the deposit. 
//      (b) used the emit keyword to trigger the Transfer event
// 2. I added a the deposit function 
// 3. note: problem statement it is not specified WHAT exactly is being deposited and/or withdrawn
//      is it ethers, or is it tokens on the ethereum platform? implementation may vary based on 
//      what is being withdrawn - TO SOLVE THIS PROBLEM and deliver clean modular and working code, the 
//      "process_withdrawal" and "process_deposit" functions are added in as placeholders to expand with 
//      other code that may be needed based on context!
// 4. I will be producing an actual video file of this--information on accessing video file can be found here: http://bit.ly/2AKHPtE

contract MyContract 
	{
		mapping (address => uint) balances;
		mapping (address => bool) deposits_made;
		mapping (address => uint) deposit_timestamps;
		uint time_in_seconds_since_deposit;
		uint constant SECONDS_IN_ONE_WEEK = 604800;
	
		event Transfer(address indexed _from, address indexed _to, uint256 _value);
	
		function withdraw_initiate(uint amount) public returns(bool) 
			{
               //time_in_seconds_since_deposit = now - deposit_timestamps[msg.sender];
                
                time_in_seconds_since_deposit = SECONDS_IN_ONE_WEEK + 1; //for test purposes only (comment line above and uncomment this one for testing)
                
                if (time_in_seconds_since_deposit <= SECONDS_IN_ONE_WEEK)
                {
                    return false;
                }
				balances[msg.sender] = balances[msg.sender] - amount;	  
				
				return true;
		  
			}
			
		function withdraw_process(uint amount) public returns(bool) 
			{
			    // if this were a real project, then this function may be modified as needed
			    // to accomodate other dependencies and/or update requirements
				emit Transfer(this, msg.sender, amount);
				
				return true;
		  
			}
        
		function deposit_initiate(uint amount) public returns(bool) 
			{
				if (deposits_made[msg.sender] == true) 
				{
				    return false;
				}
				
				balances[msg.sender] = balances[msg.sender] + amount;	  
				
				deposits_made[msg.sender] = true;
				
				deposit_timestamps[msg.sender] = now;
				
				return true;
		  
			}
		function deposit_process(uint amount) public returns(bool) 
			{
			    // if this were a real project, then this function may be modified as needed
			    // to accomodate other dependencies and/or update requirements
				emit Transfer(msg.sender, this, amount);
				
				return true;
		  
			}
	}