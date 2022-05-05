Shader "Custom/fire"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2 ("Albedo (RGB)", 2D) = "white" {} // 두 번째 불 텍스처를 받는 인터페이스 추가
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
        sampler2D _MainTex2; // 두 번째 불 텍스처를 받아서 저장할 변수

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2; // 두 번째 텍스처를 입힐 때 사용할 Quad 버텍스의 uv 좌표값
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);

            // 두 번째 텍스처로부터 가져올 texel 값을 저장할 float4 변수인 d
            fixed4 d = tex2D(_MainTex2, float2(IN.uv_MainTex2.x, IN.uv_MainTex2.y - _Time.y)); // 두 번째 불 텍스처를 y방향으로 위로 움직이도록 하려고 _Time 값을 빼줌. -> 이 텍스처는 위아래가 연결되도록 만들어진 텍스처라서 자연스럽게 연속적으로 흘러가는 애니메이션을 만들 수 있음. 

            // 불 이미지가 조명의 영향을 받지 않도록 (조명의 영향을 받으면 불처럼 안보이니까!) o.Albedo 가 아닌, 조명값과 무관한 o.Albedo 에 rgb 값을 할당해준 것! p.97 에 Emission 관련 내용 적혀있으니 참고!
            //o.Albedo = c.rgb;
            o.Emission = c.rgb * d.rgb; // 두 텍스쳐의 텍셀값의 rgb 를 곱해서 o.Emission 에 넣어줌.
            o.Alpha = c.a * d.a; // 두 텍스쳐의 텍셀값의 alpha 값도 곱해서 o.Alpha 에 넣어줌.
            // 이런 식으로 두 텍스처의 rgb 이미지와 alpha 이미지를 각각 곱해주면, 움직이지 않는 c 텍스처와 움직이는 d 텍스처가 곱해지면서 마치 위로 움직이는 듯한 효과를 낼 수 있음. -> 텍스처 두 장의 곱하기 연산이라 가볍고 효과도 좋음! 
        }
        ENDCG
    }
    FallBack "Diffuse"
}
