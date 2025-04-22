const mongoose = require('mongoose');

const trailerSchema = new mongoose.Schema({
  filmId: { type: String, required: true, unique: true },
  trailerUrl: { type: String, required: true },
});

const Trailer = mongoose.model('Trailer', trailerSchema);
module.exports = Trailer;
