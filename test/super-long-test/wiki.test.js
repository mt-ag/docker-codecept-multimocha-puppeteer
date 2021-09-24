Feature(`Super Long Test`);

// Scenario(`Wikipedia`, async ({ I }) => {
//   I.amOnPage(`https://de.wikipedia.org/wiki/Wikipedia:Hauptseite`);

//   for (let i = 0; i <= 25; i++) {
//     I.waitForElement(`#n-randompage > a`, 10);
//     I.click(`#n-randompage > a`);
//     I.wait(1);
//     //I.saveScreenshot("what.png");
//     I.waitForElement(`.mw-wiki-logo`, 10);
//     I.wait(1);
//     I.click(`.mw-wiki-logo`);
//   }
// });

Scenario(`Reddit`, async ({ I }) => {
  I.amOnPage(`https://www.reddit.com/`);

  for (let i = 0; i <= 25; i++) {
    I.waitForElement(`div[data-testid="post-container"]`, 10);
    I.scrollPageToBottom();
    I.wait(5);
    I.executeScript(() => {
      const allFinds = document.querySelectorAll(
        `a[data-click-id="subreddit"]`
      );
      const rndm = parseInt(Math.random() * allFinds.length);
      allFinds[rndm].click();
    });
    I.wait(2);
    I.scrollPageToBottom();
    I.waitForElement(`a[aria-label="Home"]`, 10);
    I.click(`a[aria-label="Home"]`);
    I.wait(5);
  }
});
