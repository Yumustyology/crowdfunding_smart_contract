// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract CrowdingFunding {
    struct  Campaign {
        address owner;
        string title;
        string description;
        uint256 target;
        uint256 endDate;
        uint256 amountRaised;
        address[] donators;
    }
    mapping(uint256 => Campaign) public campaigns;

    uint256 public campaignCount = 0;

    function createCampaign(address _owner, string memory _title, string memory _description, uint256 _target, uint256 _deadline) public returns (uint256){
        Campaign storage campaign = campaigns[campaignCount];
        
        require(campaign.deadline < block.timestamp, "The deadline can't be set to the past date");

        campaign.owner = _owner;
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.amountRaised = 0;

        campaignCount++;

        return campaignCount;
    }

    function donateTocCampaign(uint256 _id) public payable {
        uint265 amount = msg.value

        Campaign storage campaign = campaigns[_id];
        campaign.donators.push(mag.sender);
        campaign.donations.push(amount)
        
        (bool sent,) = payable(campaign.owner).call(value: amount)("");

        if(sent){
            campaign.amountRaised = campaign.amountRaised + amount;
        }
    }

    function getDonators(uint256 _id) view public returns (address[] memory, uint256[] memory){
        return (campaigns[_id].donators, campaign[_id].donations)
    }

    function getCampaigns() public view returns (Campaign[] memory){
        Campaign[] memory allCampaigns = new Campaign[](campaignCount)

        for(uint 1 = 0; i < campaignCount; i++){
            Campaign storage item = campaign[i]

            allCampaigns[i] = item
        }

        return allCampaigns
    }
}