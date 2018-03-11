module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // to customize your Truffle configuration!
  networks: {
    development: {
      port: 8545,
      host: "localhost",
      network_id: "*" // match any
    }
  }
};
