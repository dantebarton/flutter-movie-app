const express = require('express');
const router = express.Router();
const trailerController = require('../controllers/trailerController');

// Route to add a trailer
router.post('/trailers', trailerController.addTrailer);

// Route to get trailer by filmId
router.get('/trailers/:filmId', trailerController.getTrailerByFilmId);

module.exports = router;
