Shader "Custom/fire"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent"} // 불 텍스쳐를 투명하게 만들기 위해 추가된 코드.
        LOD 200
        // Cull off // Quad 같은 메쉬 요소는 유니티에서 기본적으로 백페이스 컬링이 적용되서 뒷면은 렌더링되지 않음. -> Cull off 명령어로 이거를 해제하면 양면 렌더링 처리됨!

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard alpha:fade // 불 텍스쳐를 투명하게 만들기 위해 추가된 코드.

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);

            // 불 이미지가 조명의 영향을 받지 않도록 (조명의 영향을 받으면 불처럼 안보이니까!) o.Albedo 가 아닌, 조명값과 무관한 o.Albedo 에 rgb 값을 할당해준 것! p.97 에 Emission 관련 내용 적혀있으니 참고!
            //o.Albedo = c.rgb;
            o.Emission = c.rgb;
            
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
