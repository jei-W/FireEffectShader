Shader "Custom/Surf/FireEffect"
{
    Properties
    {
		_MainTex ("MainTexture", 2D) = "white" {}
		_Noise ("Noise", 2D) = "black" {}
		_Strength ("Strength", Range(0, 2)) = 1
    }

    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard noambient alpha:fade

		sampler2D _MainTex;
		sampler2D _Noise;
		half _Strength;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
			fixed4 c = tex2D(_Noise, IN.uv_MainTex - float2(0, _Time.y));
			fixed4 d = tex2D (_MainTex, IN.uv_MainTex + (c.r - 0.12) * _Strength);

			o.Emission = d.rgb;
			o.Alpha = d.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
