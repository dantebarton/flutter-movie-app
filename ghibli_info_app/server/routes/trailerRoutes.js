const express = require('express');
const router = express.Router();
const trailerController = require('../controllers/trailerController');
const rateLimit = require('express-rate-limit');

// Route to add a trailer
router.post('/trailers', trailerController.addTrailer);

// Rate limiter for GET /trailers/:filmId route (100 requests per 15 minutes per IP)
const getTrailerLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // limit each IP to 100 requests per windowMs
  message: "Too many requests, please try again later.",
});

// Route to get trailer by filmId
router.get('/trailers/:filmId', getTrailerLimiter, trailerController.getTrailerByFilmId);

module.exports = router;
