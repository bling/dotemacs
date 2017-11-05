const express = require('express');
const bodyParser = require('body-parser');
const plantuml = require('node-plantuml');
const Readable = require('stream').Readable;

const app = express();

app.use(bodyParser.text());

plantuml.useNailgun();

app.post('/svg', function(req, res) {
  res.set('Content-Type', 'image/svg+xml');

  const uml = new Readable();
  uml.push(req.body);
  uml.push(null);

  const gen = plantuml.generate({format: 'svg'});

  uml.pipe(gen.in);
  gen.out.pipe(res);
});

app.listen(8182);
