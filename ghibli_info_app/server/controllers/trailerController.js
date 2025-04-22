const Trailer = require('../models/trailer');

// Add a trailer
exports.addTrailer = async (req, res) => {
  const { filmId, trailerUrl } = req.body;

  if (!filmId || !trailerUrl) {
    return res.status(400).send('Both filmId and trailerUrl are required.');
  }

  try {
    const newTrailer = new Trailer({ filmId, trailerUrl });
    await newTrailer.save();
    res.status(201).send(newTrailer);
  } catch (err) {
    res.status(500).send(err.message);
  }
};

// Get a trailer by filmId
exports.getTrailerByFilmId = async (req, res) => {
  const { filmId } = req.params;

  try {
    const trailer = await Trailer.findOne({ filmId });
    if (trailer) {
      res.status(200).send(trailer);
    } else {
      res.status(404).send('Trailer not found.');
    }
  } catch (err) {
    res.status(500).send(err.message);
  }
};
