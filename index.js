const { Pool } = require("pg");

// PostgreSQL connection
const pool = new Pool({
  user: "adewalegbadamosi",
  host: "localhost",
  database: "postgres",
  password: "Walexsai.00",
  port: 5432,
});

/**
 * Creates the database tables, if they do not already exist.
 */
async function createTable() {
  try {
    await pool.query(`
      CREATE TABLE IF NOT EXISTS Movies (
        movie_id SERIAL PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        release_year INT NOT NULL,
        genre VARCHAR(50) NOT NULL,
        director VARCHAR(100) NOT NULL
      );
      
      CREATE TABLE IF NOT EXISTS Customers (
        customer_id SERIAL PRIMARY KEY,
        first_name VARCHAR(100) NOT NULL,
        last_name VARCHAR(100) NOT NULL,
        email VARCHAR(255) UNIQUE NOT NULL,
        phone_number VARCHAR(15)
      );
      
      CREATE TABLE IF NOT EXISTS Rentals (
        rental_id SERIAL PRIMARY KEY,
        movie_id INT REFERENCES Movies(movie_id),
        customer_id INT REFERENCES Customers(customer_id),
        rental_date DATE NOT NULL,
        return_date DATE
      );
    `);
    console.log("Tables created successfully.");
  } catch (error) {
    console.error("Error creating tables:", error);
  }
}

/**
 * Inserts a new movie into the Movies table.
 *
 * @param {string} title Title of the movie
 * @param {number} year Year the movie was released
 * @param {string} genre Genre of the movie
 * @param {string} director Director of the movie
 */
async function insertMovie(title, year, genre, director) {
  // TODO: Add code to insert a new movie into the Movies table
}

/**
 * Prints all movies in the database to the console
 */
async function displayMovies() {
  // TODO: Add code to retrieve and print all movies from the Movies table
}

/**
 * Updates a customer's email address.
 *
 * @param {number} customerId ID of the customer
 * @param {string} newEmail New email address of the customer
 */
async function updateCustomerEmail(customerId, newEmail) {
  // TODO: Add code to update a customer's email address
}

/**
 * Removes a customer from the database along with their rental history.
 *
 * @param {number} customerId ID of the customer to remove
 */
async function removeCustomer(customerId) {
  // TODO: Add code to remove a customer and their rental history
}

/**
 * Prints a help message to the console
 */
function printHelp() {
  console.log("Usage:");
  console.log("  insert <title> <year> <genre> <director> - Insert a movie");
  console.log("  show - Show all movies");
  console.log("  update <customer_id> <new_email> - Update a customer's email");
  console.log("  remove <customer_id> - Remove a customer from the database");
}

/**
 * Runs our CLI app to manage the movie rentals database
 */
async function runCLI() {
  await createTable();

  const args = process.argv.slice(2);
  switch (args[0]) {
    case "insert":
      if (args.length !== 5) {
        printHelp();
        return;
      }
      await insertMovie(args[1], parseInt(args[2]), args[3], args[4]);
      break;
    case "show":
      await displayMovies();
      break;
    case "update":
      if (args.length !== 3) {
        printHelp();
        return;
      }
      await updateCustomerEmail(parseInt(args[1]), args[2]);
      break;
    case "remove":
      if (args.length !== 2) {
        printHelp();
        return;
      }
      await removeCustomer(parseInt(args[1]));
      break;
    default:
      printHelp();
      break;
  }
}

runCLI();
