Feature(`Samplet Test`);
Scenario(`Wikipedia`, async ({ I }) => {
  I.amOnPage(`https://www.wikipedia.org/`);
  I.waitForElement(`#searchInput`, 5);
  I.fillField(`#searchInput`, `JavaScript`);
  I.click(`#search-form > fieldset > button`);
  I.wait(5);
  I.saveScreenshot("Chromium_Wikipedia.png");
});

Scenario(`Whatsmybrowser`, async ({ I }) => {
  I.amOnPage(`https://www.whatsmybrowser.org/`);
  I.wait(5);
  I.saveScreenshot("Chromium_Whatsmybrowser.png");
});
