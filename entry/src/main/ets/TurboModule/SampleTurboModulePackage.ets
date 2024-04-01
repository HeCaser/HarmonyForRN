/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

import {RNPackage, TurboModulesFactory} from 'rnoh/ts';
import {TurboModule, TurboModuleContext} from 'rnoh/ts';
import {SampleTurboModule} from './SampleTurboModule';

class SampleTurboModulesFactory extends TurboModulesFactory {
  createTurboModule(name: string): TurboModule | null {
    if (name === 'SampleTurboModule') {
      return new SampleTurboModule(this.ctx);
    }
    return null;
  }

  hasTurboModule(name: string): boolean {
    return name === 'SampleTurboModule' ;
  }
}

export class SampleTurboModulePackage extends RNPackage {
  createTurboModulesFactory(ctx: TurboModuleContext): TurboModulesFactory {
    return new SampleTurboModulesFactory(ctx);
  }
}