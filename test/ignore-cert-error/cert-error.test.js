Feature(`Cert Error`);
Scenario(`Go to self-signed.badssl.com`, async ({ I }) => {
  I.amOnPage(`https://self-signed.badssl.com/`);
  I.waitForElement(`h1`, 5);
});
