'use strict';

const HW = artifacts.require('../contracts/HelloWorld.sol');

contract('HW', function(accounts) {
    let hw;

    beforeEach(async function() {
        hw = await HW.new();
    });

    describe('greet', function() {
      it('should greet the user', async function() {
        let result = await hw.greet("Test User");
      	assert.equal(result, 'Hello Test User');
      })
    });
  });
