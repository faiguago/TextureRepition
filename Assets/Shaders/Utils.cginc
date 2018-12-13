#ifndef ___UTILS___
#define ___UTILS___

sampler2D _Noise;
float _NoiseScale;

float sum(float4 v)
{
    return v.x + v.y + v.z + v.w;
}

// Based on 
// http://www.iquilezles.org/www/articles/texturerepetition/texturerepetition.htm

float4 textureNoTile(sampler2D tex, float2 uv)
{
    float k = tex2D(_Noise, 0.005 * _NoiseScale * uv).x;
 
    float2 duvdx = ddx(uv);
    float2 duvdy = ddx(uv);
    
    float l = k * 8.0;
    float i = floor(l);
    float f = frac(l);
    
    float2 offa = sin(float2(3.0, 7.0) * (i + 0.0));
    float2 offb = sin(float2(3.0, 7.0) * (i + 1.0));

    float4 cola = tex2D(tex, uv + offa, duvdx, duvdy);
    float4 colb = tex2D(tex, uv + offb, duvdx, duvdy);
    
    return lerp(cola, colb, smoothstep(0.2, 0.8, f - 0.1 * sum(cola - colb)));
}

#endif