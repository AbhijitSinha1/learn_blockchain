var express = require('express')
var exphbs = require('express-handlebars');
var path = require('path');
var express_handlebars_sections = require('express-handlebars-sections');
var Web3 = require('web3');
var bodyParser = require('body-parser')
var app = express()

app.engine('hbs', exphbs({defaultLayout: 'main'}));
app.set('view engine', 'hbs');
app.set('port', process.env.PORT || 3000);
app.use( bodyParser.json() );       // to support JSON-encoded bodies
app.use(bodyParser.urlencoded({     // to support URL-encoded bodies
  extended: true
}));

var options = {
  dotfiles: 'ignore',
  etag: false,
  extensions: ['htm', 'html', 'js', 'css'],
  index: false
};
// app.use(express.static(path.join(__dirname, 'public') , options  ));
app.use('/static', express.static(path.join(__dirname, 'public')))

var hbs = exphbs.create({
    // properties used by express-handlebars configuration ...
});
// express_handlebars_sections(hbs);   // CONFIGURE 'express_handlebars_sections'

app.engine('hbs', exphbs({
    section: express_handlebars_sections()  // CONFIGURE 'express_handlebars_sections'

    // properties used by express-handlebars configuration ...
}));

var web3;

if (typeof web3 !== 'undefined') {
  web3 = new Web3(web3.currentProvider);
} else {
  // set the provider you want from Web3.providers
  web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
}

web3.eth.defaultAccount = web3.eth.accounts[0];
var contractAddress = "0x351dd164014eb20bb0da786cad540c2b4de9e5a0";

var musicFileTrackerContract = web3.eth.contract([{"constant":false,"inputs":[{"name":"fileId","type":"uint256"},{"name":"filename","type":"bytes32"},{"name":"downloadPrice","type":"uint256"},{"name":"openPrice","type":"uint256"}],"name":"createFile","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"kill","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"createFileStore","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"fileId","type":"uint256"}],"name":"openFile","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"fileId","type":"uint256"}],"name":"downloadFile","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":false,"inputs":[{"name":"fileId","type":"uint256"}],"name":"removeFile","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"name":"_fileStoreAddress","type":"address"}],"name":"setFileStore","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"fileId","type":"uint256"}],"name":"getFileInfo","outputs":[{"name":"","type":"bytes32"},{"name":"","type":"uint256"},{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"getFileIds","outputs":[{"name":"","type":"uint256[100]"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"}]);

var musicFileTracker = musicFileTrackerContract.at(contractAddress);
// musicFileTracker.createFileStore();

app.get('/', function (req, res) {
  res.render('home', {title: "Home", body: "Home testing"});
});

app.get('/users', function(req, res) {
  var accounts = web3.eth.accounts;
  res.send(accounts);
});

app.get('/user/:account/balance', function(req, res) {
  var account = req.params.account;
  var balance = web3.eth.getBalance(account);
  res.send(balance);
})

app.post('/user/:account/create', function(req, res) {
  var account = req.params.account;
  var fileId = parseInt(req.body.fileId);
  var fileName = req.body.fileName;
  var downloadPrice = parseInt(req.body.downloadPrice);
  var openPrice = parseInt(req.body.openPrice);

  musicFileTracker.createFile(fileId, fileName, downloadPrice, openPrice, {from: account}, function(error) {
    if(!error) {
      res.send({
        account,
        fileId,
        fileName,
        downloadPrice,
        openPrice
      });
    } else {
      res.status(400).send(error);
    }
  });
});

app.post('/user/:account/remove/:fileId', function(req, res) {
});

app.post('/user/:account/download/:fileId', function(req, res) {
  var account = req.params.account;
  var fileId = parseInt(req.params.account);
  var price = parseInt(req.body.price);
  musicFileTracker.downloadFile(fileId, {from: account, value: price}, function(error) {
    if(!error) {
      res.send(true);
    } else {
      res.status(400).send(error);
    }
  })
});

app.post('/user/:account/open/:fileId', function(req, res) {
  var account = req.params.account;
  var fileId = parseInt(req.params.account);
  var price = parseInt(req.body.price);
  musicFileTracker.openFile(fileId, {from: account, value: price}, function(error) {
    if(!error) {
      res.send(true);
    } else {
      res.status(400).send(error);
    }
  })
});


app.listen(app.get('port'),  function () {
  console.log('Hello express started on http://localhost:' +
  app.get('port') + '; press Ctrl-C to terminate.' );
});
