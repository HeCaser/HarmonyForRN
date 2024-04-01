/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
 */

import { TurboModule } from 'rnoh/ts';
import emitter from '@ohos.events.emitter';

export interface TurboModuleEventData {
  param: string
}

export class SampleTurboModule extends TurboModule {
  pushStringToHarmony(arg: string, id?: number): string {
    if (id){
      let data: TurboModuleEventData = {param: arg}
      emitter.emit({ eventId: id } , {data: data})
    }
    return arg;
  }

  registerFunction(onComplete: (value: string) => void): void {
    console.log(`RNOH SampleTurboModule::registerFunction + trigger`);
    setTimeout(() => {
      onComplete?.('... from native side');
    }, 1000);
  }

  doAsyncJob(shouldResolve: boolean): Promise<string> {
    return new Promise((resolve, reject) => {
      setTimeout(() => {
        if (shouldResolve) {
          resolve('resolved on native side');
        } else {
          reject('rejected on native side');
        }
      }, 100);
    });
  }

  rnLog(info: string) {
    console.log("hepan ReactNative.log: " + info)
  }

}