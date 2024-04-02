import { SamplePackage } from 'rnoh-sample-package';
import { RNPackageContext, RNPackage } from 'rnoh/ts';
import { SampleTurboModulePackage } from  './TurboModule/SampleTurboModulePackage'

export function createRNPackages(ctx: RNPackageContext): RNPackage[] {
  // 当不同的 Package 包含相同的 TurboModule, 以后注入的为准
  return [new SamplePackage(ctx),new SampleTurboModulePackage(ctx)];
}
