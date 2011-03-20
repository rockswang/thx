/**
 * ...
 * @author Franco Ponticelli
 */

import utest.Runner;
import utest.ui.Report;

class TestAll
{
	public static function addTests(runner : Runner)
	{
		thx.collections.TestAll.addTests(runner);
		thx.color.TestAll.addTests(runner);
		thx.doc.TestAll.addTests(runner);
		runner.addCase(new thx.config.TestConfigs());
		thx.data.TestAll.addTests(runner);
		thx.error.TestAll.addTests(runner);
		thx.text.TestAll.addTests(runner);
		thx.html.TestAll.addTests(runner);
		thx.math.TestAll.addTests(runner);
		thx.xml.TestAll.addTests(runner);
		thx.type.TestAll.addTests(runner);
		thx.util.TestAll.addTests(runner);
		thx.validation.TestAll.addTests(runner);
	}
	
	public static function main()
	{
		var runner = new Runner();
		addTests(runner);
		Report.create(runner);
		runner.run();
	}
}