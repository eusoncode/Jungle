describe('Product details', () => {
  beforeEach(() => {
    // Visit the home page before each test
    cy.visit('http://localhost:3000/');
  });

  it('Navigates to product details page from home page', () => {
    // Find and click on a product link from the home page
    cy.get('.products article').first().click(); // Adjust the selector to match your product link

    // Validate if the URL changes to the product detail page
    cy.url().should('include', '/products/'); // Adjust the URL as per your application's routing

    // Validate elements or content on the product details page
    cy.get('.product-detail').should('be.visible'); // Validate the presence of product details
  });
});
