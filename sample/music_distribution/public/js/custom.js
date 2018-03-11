var Z = new (function() {
  this.name = function(name) {
    return document.getElementsByName(name)[0];
  };
  this.nameAll = function(name) {
    return document.getElementsByName(name);
  };
})();

var MT = new (function() {
  this.fetchBalance = function(account, callback) {
    axios.get("/user/"+account+"/balance")
    .then(function(response) {
      callback(null, response.data);
    }).catch(function(error) {
      callback(error, null);
    })
  }

  this.fetchAccounts = function(callback) {
    axios.get("/users")
    .then(function(response) {
      callback(null, response.data);
    }).catch(function(error) {
      callback(error, null);
    })
  }

  this.createFile = function(account, fileName, downloadPrice, openPrice, callback) {
    var fileId = Date.now();
    var file = {
      fileId: fileId,
      fileName: fileName,
      downloadPrice: downloadPrice,
      openPrice: openPrice
    };
    axios.post("/user/" + account + "/create", file)
    .then(function(response) {
      callback(null, response.data);
    })
    .catch(function(error) {
      callback(error, null);
    })
  }

  this.downloadFile = function(account, fileId, value, callback) {
    axios.post("/user/"+account+"/download/"+fileId, {price: value})
    .then(function(response) {
      callback(null, response.data);
    })
    .catch(function(error) {
      callback(error, null);
    })
  }

  this.openFile = function(account, fileId, value, callback) {
    axios.post("/user/"+account+"/open/"+fileId, {price: value})
    .then(function(response) {
      callback(null, response.data);
    })
    .catch(function(error) {
      callback(error, null);
    })
  }
})();
