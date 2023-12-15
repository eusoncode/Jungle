describe('visit jungle app', () => {

  it('confirms page load', () => {
    cy.visit('http://localhost:3000/'); // Visiting the specified URL
    cy.url().should('include', 'localhost:3000'); // Verifying the URL includes localhost:3000
    cy.get('body').should('be.visible'); // Verifying that the page content is visible
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible"); // Verifying that the there is products on the page
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });

});