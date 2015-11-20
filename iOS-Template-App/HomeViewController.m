/*
 * JBoss, Home of Professional Open Source.
 * Copyright Red Hat, Inc., and individual contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize button, name, result;

- (void)viewDidLoad {
  [super viewDidLoad];
}


- (IBAction)cloudCall:(id)sender {
    [FH initWithSuccess:^(FHResponse *response) {
        NSLog(@"initialized OK");
        
        NSDictionary *args = [NSDictionary dictionaryWithObject:name.text forKey:@"hello"];
        FHCloudRequest *req = (FHCloudRequest *) [FH buildCloudRequest:@"/hello" WithMethod:@"POST" AndHeaders:nil AndArgs:args];
        
        [req execAsyncWithSuccess:^(FHResponse * res) {
            // Response
            NSLog(@"Response: %@", res.rawResponseAsString);
            result.text = [res.parsedResponse objectForKey:@"msg"];
        } AndFailure:^(FHResponse * res){
            // Errors
            NSLog(@"Failed to call. Response = %@", res.rawResponseAsString);
            result.text = res.rawResponseAsString;
        }];
        
    } AndFailure:^(FHResponse *response) {
        NSLog(@"initialize fail, %@", response.rawResponseAsString);
    }];
}

@end
