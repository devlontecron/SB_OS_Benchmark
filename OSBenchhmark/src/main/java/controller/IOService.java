package controller;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.Reader;
import java.io.Writer;
import java.nio.charset.Charset;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/io")
public class IOService {

	/**
	 * Send file write size (in bytes)
	 * @param requestedSize
	 * @return
	 */
	@RequestMapping(value = "/write/{requestedSize}", method = RequestMethod.POST)
	public Map<String, Object> writeToDisk(@RequestVariable int requestedSize) {

		long start = System.currentTimeMillis();

		UUID uuid = UUID.randomUUID();
		File file = new File(uuid + ".txt");
		Writer writer = new FileWriter(file);

		byte[] array = new byte[requestedSize];
		new Random().nextBytes(array);
		String generatedString = new String(array, Charset.forName("UTF-8"));

		writer.write(generatedString);

		writer.flush();
		writer.close();

		long end = System.currentTimeMillis();

		String elapsedTime = ((end - start) / 1000f + " seconds");

		return file.getName() + elapsedTime;

	}

	/**
	 * send file name options (which will be pre loaded), each file increasing in size (100.txt, 5000.txt etc.)
	 * @param fileName
	 * @return
	 */
	@RequestMapping(value = "/read/{fileName}", method = RequestMethod.POST)
	public String readFromDisk(@RequestVariable String fileName) {
		
		long start = System.currentTimeMillis();
		
		Reader reader = new FileReader(fileName);
		
		StringBuffer sb = new StringBuffer(); 
		sb.append(reader.read());
		
		long end = System.currentTimeMillis();
		
		String elapsedTime = ((end - start) / 1000f + " seconds");
		
		return elapsedTime;

	}

}
