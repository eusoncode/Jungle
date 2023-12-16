describe('Add to Cart', () => {
  beforeEach(() => {
    // Visit the home page before each test
    cy.visit('http://localhost:3000/');
  });

  it('Increases cart count after adding a product', () => {
    // Locate the 'Add to Cart' button for a specific product and click it using {force: true}
    cy.get('.products article button').first().click({ force: true }); // Adjust the selector to match your 'Add to Cart' button

    // Validate if the cart count increases by one after clicking 'Add to Cart'
    cy.get('.nav-link_c').invoke('text').should('match', /My Cart \(\d+\)/); // Adjust the selector to match your cart count
  });
});
