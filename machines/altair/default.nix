{ config, lib, pkgs, ... }:

{
  system.defaults = {
    # All the following numbers of concurrent tasks are the same as
    # `sysctl -n hw.ncpu`.
    CustomUserPreferences = {
      "com.apple.dt.Xcode" = {
        "IDEBuildOperationMaxNumberOfConcurrentCompileTasks" = 10;
        "PBXNumberOfParallelBuildSubtasks" = 10;
      };
      "com.apple.dt.xcodebuild" = {
        "IDEBuildOperationMaxNumberOfConcurrentCompileTasks" = 10;
        "PBXNumberOfParallelBuildSubtasks" = 10;
      };
    };
  };
}
