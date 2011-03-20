/**
 * ...
 * @author Franco Ponticelli
 */

package thx.data;

import utest.Assert;
import utest.Runner;
import utest.ui.Report;

class TestAll
{
	public static function addTests(runner : Runner)
	{
		runner.addCase(new TestHttpLoader());
		runner.addCase(new TestMemoryLoader());
	}
	
	public static function main()
	{
		var runner = new Runner();
		addTests(runner);
		Report.create(runner);
		runner.run();
	}
	
	public function new();
}