//Copyright (c) 2021 Cloud CNC

#include "utils/IntPoint.h"

#ifdef ENABLE_WASM_CALLBACKS
namespace wasm_callbacks
{
  #ifdef __cplusplus
  extern "C"
  {
  #endif

    /*!
     * Emit the slicer progress
     */
    extern void emitProgress(float progress);

    /*!
     * Emit the slice metadata
     */
    extern void emitMetadata(
      std::string flavor,
      int print_time,
      double material_usage[],
      uint32_t material_usage_size,
      double bounding_box[],
      uint32_t bounding_box_size
    );

  #ifdef __cplusplus
  }
  #endif
}//namespace wasm_callbacks
#endif