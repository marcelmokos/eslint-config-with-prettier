// @flow
import fs from "fs";

describe("Eslint rules will output same markup", () => {
  it("match", () => {
    const text = fs.readFileSync("./src/test-markup.output.js", "utf8");

    expect(text).toMatchSnapshot();
  });
});
