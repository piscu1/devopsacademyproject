var appInsights = require("applicationinsights");
var express = require('express');
var path = require('path');

var routes = require('./routes/index.js');

const connectionString = process.env.APPLICATIONINSIGHTS_CONNECTION_STRING;

if (connectionString && connectionString.trim() !== '') {
  appInsights.setup(connectionString)
    .setAutoCollectRequests(true)
    .setAutoCollectPerformance(true)
    .setAutoCollectExceptions(true)
    .setAutoCollectDependencies(true)
    .setAutoCollectConsole(true)
    .setSendLiveMetrics(true)
    .start();

  console.log('Application Insights started');
} else {
  console.warn('Application Insights connection string not found. Telemetry disabled.');
}


var app = express();

app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');

app.use(require('morgan')('combined'));
app.use(require('cookie-parser')());
app.use(require('body-parser').urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, '/views')));

if (appInsights.defaultClient) {
  app.use((req, res, next) => {
    const startTime = Date.now();

    res.on('finish', () => {
      const duration = Date.now() - startTime;
      appInsights.defaultClient.trackRequest({
        name: `${req.method} ${req.originalUrl}`,
        url: req.protocol + '://' + req.get('host') + req.originalUrl,
        duration: duration,
        resultCode: res.statusCode,
        success: res.statusCode < 400,
        time: new Date()
      });
    });

    next();
  });
}

app.use('/', routes);

let server;
if (process.env.NODE_ENV !== 'test') {
  const port_running = process.env.PORT || 80;
  server = app.listen(port_running, () => {
    console.log("Application running at port: " + port_running);
  });
}

module.exports = { app, server };
