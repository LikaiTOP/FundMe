// SPDX-License_identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {console} from "forge-std/console.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        // The next line runs before the vm.startBroadcast() is called
        // This will not be deployed because the `real` signed txs are happening
        // between the start and stop Broadcast lines.
        HelperConfig helperConfig = new HelperConfig();
        address ethUsdPriceFeed = helperConfig.activeNetworkConfig();
        // address ethUsdPriceFeed = helperConfig.activeNetworkConfig().priceFeed;

        console.log("ethUsdPriceFeed:", ethUsdPriceFeed);

        vm.startBroadcast();
        FundMe fundMe = new FundMe(ethUsdPriceFeed);
        vm.stopBroadcast();
        return fundMe;
    }
}
