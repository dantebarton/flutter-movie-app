require('dotenv').config(); // Load environment variables from .env file
const mongoose = require('mongoose');
const Trailer = require('./models/trailer'); // Import the Trailer model

// Connect to MongoDB
const mongoURI = process.env.MONGO_URI;
if (!mongoURI) {
  console.error('MONGO_URI is not set in the environment variables');
  process.exit(1);
}
mongoose.connect(mongoURI, {
  useNewUrlParser: true,
  useUnifiedTopology: true
})
.then(() => {
  console.log('Connected to MongoDB');
  
  // Query all trailers from the database
  return Trailer.find({});
})
.then(trailers => {
  console.log('All trailers in the database:');
  if (trailers.length === 0) {
    console.log('No trailers found in the database.');
  } else {
    trailers.forEach(trailer => {
      console.log(`Film ID: ${trailer.filmId}`);
      console.log(`Trailer URL: ${trailer.trailerUrl}`);
      console.log('-------------------');
    });
    console.log(`Total trailers found: ${trailers.length}`);
  }
})
.catch(err => {
  console.error('Error connecting to MongoDB or querying trailers:', err);
})
.finally(() => {
  // Close the MongoDB connection
  mongoose.connection.close();
  console.log('MongoDB connection closed');
});

