// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TooMuchCaffeine_Shader"
{
	Properties
	{
		_NORMAL2("NORMAL2", 2D) = "bump" {}
		_NORMAL1("NORMAL1", 2D) = "bump" {}
		_MASK("MASK", 2D) = "white" {}
		_Distortion("Distortion", Float) = 0.5
		_Speed("Speed", Float) = 0
		_NormalTileDirection("NormalTileDirection", Vector) = (0,0,0,0)
		_NormalOffsetDirection("NormalOffsetDirection", Vector) = (0,0,0,0)
		_Remap("Remap", Vector) = (0,1,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPos;
		};

		uniform sampler2D _NORMAL1;
		uniform float _Speed;
		uniform float2 _NormalTileDirection;
		uniform float2 _NormalOffsetDirection;
		uniform sampler2D _NORMAL2;
		uniform sampler2D _GrabTexture;
		uniform float _Distortion;
		uniform sampler2D _MASK;
		uniform float4 _MASK_ST;
		uniform float4 _Remap;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (_Speed).xx;
			float2 uv_TexCoord36 = i.uv_texcoord * _NormalTileDirection + _NormalOffsetDirection;
			float2 panner39 = ( _SinTime.w * temp_cast_0 + uv_TexCoord36);
			float2 temp_cast_1 = (_Speed).xx;
			float2 panner38 = ( _SinTime.w * temp_cast_1 + uv_TexCoord36);
			float3 temp_output_43_0 = BlendNormals( UnpackScaleNormal( tex2D( _NORMAL1, panner39 ), 0.01 ) , UnpackScaleNormal( tex2D( _NORMAL2, panner38 ), 0.01 ) );
			o.Normal = temp_output_43_0;
			float4 temp_cast_2 = (1.0).xxxx;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float4 screenColor48 = tex2D( _GrabTexture, ( float3( (ase_grabScreenPosNorm).xy ,  0.0 ) + ( temp_output_43_0 * _Distortion ) ).xy );
			float4 lerpResult52 = lerp( temp_cast_2 , screenColor48 , 1.0);
			o.Albedo = lerpResult52.rgb;
			float2 uv_MASK = i.uv_texcoord * _MASK_ST.xy + _MASK_ST.zw;
			float4 temp_cast_6 = (_Remap.x).xxxx;
			float4 temp_cast_7 = (_Remap.y).xxxx;
			float4 temp_cast_8 = (_Remap.z).xxxx;
			float4 temp_cast_9 = (_Remap.w).xxxx;
			o.Alpha = ( 1.0 - (temp_cast_8 + (tex2D( _MASK, uv_MASK ) - temp_cast_6) * (temp_cast_9 - temp_cast_8) / (temp_cast_7 - temp_cast_6)) ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
-6;7;1155;1002;312.8088;1812.922;2.220329;True;False
Node;AmplifyShaderEditor.Vector2Node;54;-1319.157,-1017.59;Float;False;Property;_NormalTileDirection;NormalTileDirection;5;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;55;-1328.157,-877.5896;Float;False;Property;_NormalOffsetDirection;NormalOffsetDirection;6;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SinTimeNode;60;-846.3234,-626.6801;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;36;-1012,-937;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;37;-955,-761;Float;False;Property;_Speed;Speed;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;38;-593,-819;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.04,0.04;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;39;-608,-944;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.03,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;41;-352,-1040;Float;True;Property;_NORMAL1;NORMAL1;1;0;Create;True;0;0;False;0;dd2fd2df93418444c8e280f1d34deeb5;dd2fd2df93418444c8e280f1d34deeb5;True;0;True;bump;Auto;True;Instance;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;0.01;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;40;-336,-832;Float;True;Property;_NORMAL2;NORMAL2;0;0;Create;True;0;0;False;0;dd2fd2df93418444c8e280f1d34deeb5;dd2fd2df93418444c8e280f1d34deeb5;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;0.01;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendNormalsNode;43;-32,-928;Float;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;42;448,-1008;Float;False;Property;_Distortion;Distortion;3;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;44;272,-1296;Float;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;624,-1152;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;45;532.7476,-1371.792;Float;True;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;50;939.0477,-722.5294;Float;True;Property;_MASK;MASK;2;0;Create;True;0;0;False;0;31890676c5b178840848afa665cb5a2f;5228a04ef529d2641937cab585cc1a02;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;57;1231.024,-482.8489;Float;False;Property;_Remap;Remap;7;0;Create;True;0;0;False;0;0,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;47;800,-1200;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ScreenColorNode;48;1024,-1292;Float;False;Global;_WaterGrab;WaterGrab;-1;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;56;1564.969,-719.1002;Float;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;49;1040,-1072;Float;False;Constant;_Float4;Float 4;12;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;59;1778.964,-721.243;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;52;1536,-1248;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1952,-976;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;TooMuchCaffeine_Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;36;0;54;0
WireConnection;36;1;55;0
WireConnection;38;0;36;0
WireConnection;38;2;37;0
WireConnection;38;1;60;4
WireConnection;39;0;36;0
WireConnection;39;2;37;0
WireConnection;39;1;60;4
WireConnection;41;1;39;0
WireConnection;40;1;38;0
WireConnection;43;0;41;0
WireConnection;43;1;40;0
WireConnection;46;0;43;0
WireConnection;46;1;42;0
WireConnection;45;0;44;0
WireConnection;47;0;45;0
WireConnection;47;1;46;0
WireConnection;48;0;47;0
WireConnection;56;0;50;0
WireConnection;56;1;57;1
WireConnection;56;2;57;2
WireConnection;56;3;57;3
WireConnection;56;4;57;4
WireConnection;59;0;56;0
WireConnection;52;0;49;0
WireConnection;52;1;48;0
WireConnection;52;2;49;0
WireConnection;0;0;52;0
WireConnection;0;1;43;0
WireConnection;0;9;59;0
ASEEND*/
//CHKSM=94C869D24078F2B01EFE5DEEAA083D245A0A9DCC