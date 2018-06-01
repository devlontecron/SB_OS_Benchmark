package controller;

import java.util.Map;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/boot")
public class bootService {
	
	@RequestMapping(value = "/", method = RequestMethod.POST)
	public String boot(@RequestVariable int requestedSize) {
		
		/**
		 * this is all just cut/paste code from aws. 
		 * May just call script that already does this in a WAY easier fashion. (see folder (src/scripts/E01.BootScripts))
		 */
		CreateSecurityGroupRequest csgr = new CreateSecurityGroupRequest();
		csgr.withGroupName("JavaSecurityGroup").withDescription("My security group");
		
		CreateSecurityGroupResult createSecurityGroupResult =
			    amazonEC2Client.createSecurityGroup(csgr);
		
		IpPermission ipPermission =
			    new IpPermission();

			IpRange ipRange1 = new IpRange().withCidrIp("111.111.111.111/32");
			IpRange ipRange2 = new IpRange().withCidrIp("150.150.150.150/32");

			ipPermission.withIpv4Ranges(Arrays.asList(new IpRange[] {ipRange1, ipRange2}))
			            .withIpProtocol("tcp")
			            .withFromPort(22)
			            .withToPort(22);
		
			AuthorizeSecurityGroupIngressRequest authorizeSecurityGroupIngressRequest =
				    new AuthorizeSecurityGroupIngressRequest();

				authorizeSecurityGroupIngressRequest.withGroupName("JavaSecurityGroup")
				                                    .withIpPermissions(ipPermission);
				
				amazonEC2Client.authorizeSecurityGroupIngress(authorizeSecurityGroupIngressRequest);
				
				
				
				
				
				CreateKeyPairRequest createKeyPairRequest = new CreateKeyPairRequest();

				createKeyPairRequest.withKeyName(keyName);
				
				CreateKeyPairResult createKeyPairResult =
						  amazonEC2Client.createKeyPair(createKeyPairRequest);
				
				KeyPair keyPair = new KeyPair();

				keyPair = createKeyPairResult.getKeyPair();

				String privateKey = keyPair.getKeyMaterial();
				
				
				
				RunInstancesRequest runInstancesRequest =
						   new RunInstancesRequest();

						runInstancesRequest.withImageId("ami-4b814f22")
						                   .withInstanceType("m1.small")
						                   .withMinCount(1)
						                   .withMaxCount(1)
						                   .withKeyName("my-key-pair")
						                   .withSecurityGroups("my-security-group");
				
				
		long start = System.currentTimeMillis();
		
		//get the instance type and what OS
		
	//call the service to boot instance
	//loop while pinging + waiting for response
	//capture time
		//kill instance
	}
}
