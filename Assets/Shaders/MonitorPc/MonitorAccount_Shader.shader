// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MonitorAccout_Shader"
{
	Properties
	{
		_Map("Map", 2D) = "white" {}
		_Offset("Offset", Vector) = (0,0,0,0)
		_Tiling("Tiling", Vector) = (0,0,0,0)
		_Float0("Float 0", Float) = 10
		_Remap("Remap", Vector) = (0,0,0,0)
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Map;
		uniform float _Float0;
		uniform sampler2D _TextureSample1;
		uniform float2 _Tiling;
		uniform float2 _Offset;
		uniform float4 _Remap;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 smoothstepResult11 = smoothstep( float4( 0,0,0,0 ) , float4( 1,1,1,0 ) , tex2D( _Map, i.uv_texcoord ));
			float clampResult10 = clamp( ( _SinTime.w * _Float0 ) , 0.8 , 1.0 );
			float4 clampResult17 = clamp( ( smoothstepResult11 * clampResult10 ) , float4( 0,0,0,0 ) , float4( 1,1,1,0 ) );
			float2 uv_TexCoord12 = i.uv_texcoord * _Tiling + ( _Offset * _Time.y );
			float4 temp_cast_0 = (_Remap.x).xxxx;
			float4 temp_cast_1 = (_Remap.y).xxxx;
			float4 temp_cast_2 = (_Remap.z).xxxx;
			float4 temp_cast_3 = (_Remap.w).xxxx;
			float4 lerpResult18 = lerp( float4( 0,0,0,0 ) , clampResult17 , ( 1.0 - (temp_cast_2 + (tex2D( _TextureSample1, uv_TexCoord12 ) - temp_cast_0) * (temp_cast_3 - temp_cast_2) / (temp_cast_1 - temp_cast_0)) ));
			o.Emission = lerpResult18.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
1933;8;1906;1005;2825.056;909.5599;2.325008;True;True
Node;AmplifyShaderEditor.Vector2Node;4;-1950.419,176.3167;Float;False;Property;_Offset;Offset;1;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TimeNode;5;-1998.419,304.3167;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1774.419,-639.6833;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2;-1566.419,-191.6833;Float;False;Property;_Float0;Float 0;3;0;Create;True;0;0;False;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinTimeNode;3;-1550.419,-351.6833;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;7;-1774.419,64.31665;Float;False;Property;_Tiling;Tiling;2;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-1758.419,256.3167;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-1486.419,48.31665;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-1342.419,-287.6833;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;9;-1454.419,-671.6833;Float;True;Property;_Map;Map;0;0;Create;True;0;0;False;0;73e073da55a31ce4bb4eb1b4368a0d76;73e073da55a31ce4bb4eb1b4368a0d76;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;10;-1134.419,-287.6833;Float;False;3;0;FLOAT;0;False;1;FLOAT;0.8;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;11;-1150.419,-655.6833;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;15;-1183.419,-46.68335;Float;True;Property;_TextureSample1;Texture Sample 1;5;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;13;-1054.419,176.3167;Float;False;Property;_Remap;Remap;4;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-830.4191,-351.6833;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;16;-725.4191,-51.68335;Float;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;20;-492.4745,-55.98923;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;17;-542.4191,-335.6833;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldPosInputsNode;19;-1822.419,-175.6833;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;18;-302.4191,-191.6833;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;MonitorAccout_Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;4;0
WireConnection;6;1;5;2
WireConnection;12;0;7;0
WireConnection;12;1;6;0
WireConnection;8;0;3;4
WireConnection;8;1;2;0
WireConnection;9;1;1;0
WireConnection;10;0;8;0
WireConnection;11;0;9;0
WireConnection;15;1;12;0
WireConnection;14;0;11;0
WireConnection;14;1;10;0
WireConnection;16;0;15;0
WireConnection;16;1;13;1
WireConnection;16;2;13;2
WireConnection;16;3;13;3
WireConnection;16;4;13;4
WireConnection;20;0;16;0
WireConnection;17;0;14;0
WireConnection;18;1;17;0
WireConnection;18;2;20;0
WireConnection;0;2;18;0
ASEEND*/
//CHKSM=8840F8AE72F29784CED816D0A8888A527A5ED3B8