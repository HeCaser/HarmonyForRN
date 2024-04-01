import { RNPackageContext, RNPackage } from 'rnoh/ts';
import { SampleTurboModulePackage } from  './TurboModule/SampleTurboModulePackage'

export function createRNPackages(ctx: RNPackageContext): RNPackage[] {
  return [new SampleTurboModulePackage(ctx)];
}
