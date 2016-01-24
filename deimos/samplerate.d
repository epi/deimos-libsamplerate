module deimos.samplerate;

import core.stdc.config;

extern (C):

alias c_long function (void*, float**) src_callback_t;

enum SRC_SINC_BEST_QUALITY = 0;
enum SRC_SINC_MEDIUM_QUALITY = 1;
enum SRC_SINC_FASTEST = 2;
enum SRC_ZERO_ORDER_HOLD = 3;
enum SRC_LINEAR = 4;

struct SRC_DATA
{
    float* data_in;
    float* data_out;
    c_long input_frames;
    c_long output_frames;
    c_long input_frames_used;
    c_long output_frames_gen;
    int end_of_input;
    double src_ratio;
}

struct SRC_CB_DATA
{
    c_long frames;
    float* data_in;
}

struct SRC_STATE;

SRC_STATE* src_new (int converter_type, int channels, int* error);
SRC_STATE* src_callback_new (src_callback_t func, int converter_type, int channels, int* error, void* cb_data);
SRC_STATE* src_delete (SRC_STATE* state);
int src_process (SRC_STATE* state, SRC_DATA* data);
c_long src_callback_read (SRC_STATE* state, double src_ratio, c_long frames, float* data);
int src_simple (SRC_DATA* data, int converter_type, int channels);
const(char)* src_get_name (int converter_type);
const(char)* src_get_description (int converter_type);
const(char)* src_get_version ();
int src_set_ratio (SRC_STATE* state, double new_ratio);
int src_reset (SRC_STATE* state);
int src_is_valid_ratio (double ratio);
int src_error (SRC_STATE* state);
const(char)* src_strerror (int error);
void src_short_to_float_array (const(short)* in_, float* out_, int len);
void src_float_to_short_array (const(float)* in_, short* out_, int len);
void src_int_to_float_array (const(int)* in_, float* out_, int len);
void src_float_to_int_array (const(float)* in_, int* out_, int len);
