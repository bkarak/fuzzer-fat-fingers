#import <Foundation/Foundation.h>

int main (int argc, const char * argv[])
{
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        NSString *text = @"Hello,How,Are,You,Today";
		NSArray *tokens = [text componentsSeparatedByString:@","];
		NSString *result = [tokens componentsJoinedByString:@"."];
		NSLog(result);
        [pool drain];
        return 0;
}