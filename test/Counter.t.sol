// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function test_Decrement() public {
        counter.setNumber(5);
        counter.decrement();
        assertEq(counter.number(), 4);
    }

    function test_Decrement_Underflow() public {
        counter.setNumber(0);
        vm.expectRevert(Counter.Decrement_Underflow.selector);
        counter.decrement();
    }

    function test_MultiIncrement() public {
        for (uint256 i = 0; i < 5; i++) {
            counter.increment();
        }
        assertEq(counter.number(), 5);
    }

    function test_MultiDecrement() public {
        counter.setNumber(5);
        for (uint256 i = 0; i < 5; i++) {
            counter.decrement();
        }
        assertEq(counter.number(), 0);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    function test_Revert_SetNumber_Unauthorized() public {
        address unknownUser = address(0x12345);
        vm.prank(unknownUser);
        vm.expectRevert("Only owner can set the number");
        counter.setNumber(100);
    }
}
