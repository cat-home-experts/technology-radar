const functions = require('@google-cloud/functions-framework');

const version = process.env.RADAR_VERSION;
const redirectUrl = `https://radar.thoughtworks.com/?documentId=https%3A%2F%2Fraw.githubusercontent.com%2Fcat-home-experts%2Ftechnology-radar%2Fmain%2Fversions%2F${version}.json`

// Redirect to the radar version if the environment variable is set.
functions.http('redirect', (req, res) => {
  if (version === undefined) {
    res.status(404).send('RADAR_VERSION not set');
  } else {
    res.redirect(redirectUrl)
  }
});